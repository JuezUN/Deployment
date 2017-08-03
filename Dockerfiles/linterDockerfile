FROM python:3.4.6

#install ruby
RUN mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

ENV RUBY_MAJOR 2.3
ENV RUBY_VERSION 2.3.4
ENV RUBY_DOWNLOAD_SHA256 341cd9032e9fd17c452ed8562a8d43f7e45bfe05e411d0d7d627751dd82c578c
ENV RUBYGEMS_VERSION 2.6.12

# some of ruby's build scripts are written in ruby
#   we purge system ruby later to make sure our final image uses what we just built
RUN set -ex \
	\
	&& buildDeps=' \
		bison \
		dpkg-dev \
		libgdbm-dev \
		ruby \
	' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& rm -rf /var/lib/apt/lists/* \
	\
	&& wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum -c - \
	\
	&& mkdir -p /usr/src/ruby \
	&& tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.xz \
	\
	&& cd /usr/src/ruby \
	\
# hack in "ENABLE_PATH_CHECK" disabling to suppress:
#   warning: Insecure world writable dir
	&& { \
		echo '#define ENABLE_PATH_CHECK 0'; \
		echo; \
		cat file.c; \
	} > file.c.new \
	&& mv file.c.new file.c \
	\
	&& autoconf \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
		--build="$gnuArch" \
		--disable-install-doc \
		--enable-shared \
	&& make -j "$(nproc)" \
	&& make install \
	\
	&& apt-get purge -y --auto-remove $buildDeps \
	&& cd / \
	&& rm -r /usr/src/ruby \
	\
	&& gem update --system "$RUBYGEMS_VERSION"

ENV BUNDLER_VERSION 1.15.1

RUN gem install bundler --version "$BUNDLER_VERSION"

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_BIN="$GEM_HOME/bin" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
&& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

WORKDIR /usr/src/app

RUN gem install bundler

COPY . .


RUN pip3 install git+https://github.com/JuezUN/coala-bears.git

EXPOSE 4567

#install pmd java linter (coala dependency)

RUN wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-5.8.1.zip \
    && unzip pmd-bin-5.8.1.zip && alias pmd="/pmd-bin-5.8.1/bin/run.sh pmd"

#install oclinter
RUN https://github.com/oclint/oclint/releases/download/v0.12/oclint-0.12-x86_64-darwin-16.5.0.tar.gz \
	  &&  mkdir oclint-release \
		&& tar xf oclint-0.12-x86_64-darwin-16.5.0.tar.gz -C oclint-release --strip-components 1 \
		&& OCLINT_HOME=/oclint-release
		&& export PATH=$OCLINT_HOME/bin:$PATH

RUN bundle install

CMD ruby src/linter-webapp.rb
