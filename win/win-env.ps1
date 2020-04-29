# Windows environment setup script - mostly installs common stuff via choco
# Run with ADMIN privileges and bypass execution policy before executing:
#          
#     Set-ExecutionPolicy Bypass -Scope Process -Force;
#
#  jirkafm  https://github.com/jirkafm/my-env
#

param($options)

function installChoco 
{
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function installEssentialsPkgs
{
	choco install --yes 7zip clink Firefox freecommander-xe.install gawk grep keepass keepass-plugin-databasebackup msys2 netcat notepadplusplus procexp pstools putty qutebrowser sed telnet toff vim wget winscp
}

function installDevPkgs 
{
	choco install --yes docker-desktop git git-lfs nodejs vscodium wsltty
}

function installJavaDevPkgs 
{
	choco install --yes --ignore-dependencies ant gradle maven 
	choco install --yes docker-desktop eclipse git git-lfs nodejs openjdk11 openjdk14 openjdk8
}

function instalLGuiAppsPkgs 
{
	choco install --yes ffmpeg libreoffice steam tigervnc-viewer virtualbox vlc
}

installChoco

foreach ($option in $options)
{
	write-host "Considering option $($option)..."
	switch ( $option )
	{
		{$_ -match 'all'} { installEssentialsPkgs; installDevPkgs; installJavaDevPkgs; installGuiAppsPkgs }
		{$_ -match 'dev'} { installDevPkgs }
		{$_ -match 'javaDev'} { installJavaDevPkgs }
		{$_ -match 'guiapps'} { installGuiAppsPkgs }
		{$_ -match 'essentials'} { installEssentialsPkgs }
		default { write-host 'Following options are supported: all, dev, javaDev, guiapps, essentials' }
	}
}
