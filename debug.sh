#! /bin/bash

lldb-3.9 -O "settings set target.exec-search-paths /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.2/" -o "plugin load /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.2/libsosplugin.so" /usr/bin/dotnet --core /tmp/coredump.1