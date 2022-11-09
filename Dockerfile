FROM i386/alpine:latest

# Wine 32Bit for running EXE
RUN apk add --no-cache wine freetype

# Configure Wine
RUN winecfg

# Install wget and git
RUN apk add --no-cache wget git

# Download dependencies
RUN wget -P /mono https://dl.winehq.org/wine/wine-mono/7.4.0/wine-mono-7.4.0-x86.msi
RUN wget -P /alc -O alc.zip -r https://www.dropbox.com/s/8bwfutm22re82ln/ms-dynamics-smb.al-10.0.687650.vsix?dl=1

# Install Mono Runtime for .NET Applications
RUN wine msiexec /i /mono/wine-mono-7.4.0-x86.msi
RUN rm -rf /mono/wine-mono-7.4.0-x86.msi

# Install AL Language Extension
RUN unzip /alc.zip -d /alc
RUN rm -rf /alc.zip
WORKDIR /alc/extension/bin
CMD ["wine", "alc.exe"]