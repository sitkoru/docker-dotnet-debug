FROM mcr.microsoft.com/dotnet/core/sdk:2.2.105

RUN apt-get update \
    && apt-get install -y \
    wget \
    gnupg2

RUN echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.9 main" | tee /etc/apt/sources.list.d/llvm.list \
    && wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update \
    && apt-get install -y \
    binutils \
    curl \
    htop \
    procps \
    liblttng-ust-dev \
    linux-tools \
    lttng-tools \
    gdb \
    zip \
    gdb \
    lldb-3.9 \
    && rm -rf /var/lib/apt/lists/*

COPY empty.csproj /tmp

RUN cd /tmp && dotnet restore -r linux-x64 && cp `find ~/.nuget/packages -name crossgen` $(dirname `find /usr/share/dotnet/ -name libcoreclr.so`) && rm -rf /tmp/*

WORKDIR /tools

RUN curl -OL http://aka.ms/perfcollect  && chmod a+x perfcollect

COPY *.sh ./

RUN chmod +x *.sh

ENTRYPOINT ["/bin/bash"]

# /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.2/createdump 1
# lldb-3.9 -O "settings set target.exec-search-paths /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.2/" -o "plugin load /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.2/libsosplugin.so" /usr/bin/dotnet --core core.1