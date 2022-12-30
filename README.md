# FLAC-Metadata-to-MusicBrainz-Helper
A PowerShell script to display FLAC metadata in a copy paste friendly way for release-adding in MusicBrainz.


**Description**  

   This A script to make you more efficient when adding or editing releases on MusicBrainz with flac metadata as information source
   For https://musicbrainz.org/release/add
   The script will output suggestion Release information to Albuim, Artist, Release Group and Date based on metadata in first flac-file.
   It will also output a tracklist matching what the MusicBrainz parser expects, just copy-paste into "Add Medium"

   The script is relying on cmndlets in the AudioWorks.Commands module.
   https://www.powershellgallery.com/packages/AudioWorks.Commands/1.2.0
   Install-Module -Name AudioWorks.Commands
   
   I have the script better explained with pictures on my blog:
   https://flemmingss.com/i-made-a-powershell-script-to-parse-flac-metadata-for-easy-copy-pasting-into-musicbrainz/

**Bugs and issues**  
  There is probably a lot of bugs and issues, this was made on the fly as I needed it myself, and I probably won't spend much time on improvements.
  Known issues: 
- Can’t use square brackets [] in path/filename due to incompatibility in the AudioWorks module.
- Will output error if folder don’t contain any flac files
- Non-filled values will just be empty
- Release information is just based on first .flac file
   
**Changelog**  
* 30.12.2022
    * Release on GitHub
* 28.12.2022
    * Release on Blog, flemmingss.com
