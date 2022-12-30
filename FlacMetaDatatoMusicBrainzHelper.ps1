<#
.Synopsis
   Name: FlacMetaDatatoMusicBrainzHelper.ps1
   A PowerShell script to display FLAC metadata in a copy paste friendly way for release-adding in MusicBrainz.
.DESCRIPTION
   A script to make you more efficient when adding or editing releases on MusicBrainz with flac metadata as information source
   For https://musicbrainz.org/release/add
   The script will output suggestion Release information to Albuim, Artist, Release Group and Date based on metadata in first flac-file.
   It will also output a tracklist matching what the MusicBrainz parser expects, just copy-paste into "Add Medium"

   The script is relying on cmndlets in the AudioWorks.Commands module.
   https://www.powershellgallery.com/packages/AudioWorks.Commands/1.2.0
   Install-Module -Name AudioWorks.Commands
.NOTES
   Original release Date: 28.12.2022
   Author: Flemming Sørvollen Skaret
.LINK
   https://github.com/flemmingss/
   https://flemmingss.com
#>

#Requires -RunAsAdministrator
#Requires -Modules AudioWorks.Commands

Write-Host "* Flac MetaData to MusicBrainz Helper *" -ForegroundColor Magenta
Import-Module AudioWorks.Commands

do
{
    [string]$Folder = Read-Host -Prompt "Path to release"
    $Files = (Get-ChildItem -LiteralPath $Folder| Where-Object {$_.Extension -eq ".flac"}).Fullname
    $PeriodCharacter = "."
    $HyphenCharacter ="-"
    $ParenthesisStartCharacter = "("
    $ParenthesisEndCharacter = ")"
    $Album = (Get-AudioFile -Path $Files[0] | Get-AudioMetadata).Album
    $AlbumArtist = (Get-AudioFile -Path $Files[0] | Get-AudioMetadata).AlbumArtist
    $Day = (Get-AudioFile -Path $Files[0] | Get-AudioMetadata).Day
    $Month = (Get-AudioFile -Path $Files[0] | Get-AudioMetadata).Month
    $Year = (Get-AudioFile -Path $Files[0] | Get-AudioMetadata).Year

    Write-Host ""
    Write-Host "### Release information ###" -ForegroundColor Yellow
    Write-Host "Title.........: $Album"
    Write-Host "Artist........: $AlbumArtist"
    Write-Host "Release Group.: $Album"
    Write-Host "Date..........: $Year$HyphenCharacter$Month$HyphenCharacter$Day"
    Write-Host ""
    Write-Host "### Tracklist ###" -ForegroundColor Yellow

    foreach ($File in $Files)
    {
        $FileMetadata = Get-AudioFile -Path $File | Get-AudioMetadata
        $AudioInfo = Get-AudioFile -Path $File | Get-AudioInfo
        $FileTrackNumber = [int]$FileMetadata.TrackNumber
        $FileArtist = $FileMetadata.Artist
        $FileTitle = $FileMetadata.Title
        $FilePlayLength = $AudioInfo.PlayLength

        Write-Host $FileTrackNumber$PeriodCharacter $FileTitle $HyphenCharacter $FileArtist $ParenthesisStartCharacter$FilePlayLength$ParenthesisEndCharacter
    }
}
until ($Folder -eq "exit")
