########################################################################
# Modules
########################################################################

Import-Module -Name Terminal-Icons
Import-Module -Name PSReadLine

########################################################################
# Basic Settings
########################################################################

[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Function used to find path of an executable
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Check if you run with Administrator priviledges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
	$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
		if (Test-Path($ChocolateyProfile)) {
			Import-Module "$ChocolateyProfile"
		}
}

########################################################################
# PS-Readline Settings
########################################################################

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -PredictionSource History
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs

########################################################################
# Aliases
########################################################################

Set-Alias -Name vim -Value nvim

########################################################################
# Paths
########################################################################

$Projects = "D:\Projects"
