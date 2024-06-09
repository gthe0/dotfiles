########################################################################
# Modules
########################################################################

Import-Module -Name Terminal-Icons
Import-Module -Name PSReadLine

########################################################################
# Basic Settings
########################################################################

# Ensure that the encoding used is UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Function used to find the path of an executable
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
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
