#include-once
;==================================================================================================
;
;						 .S_SSSs     .S_SSSs     .S_SsS_S.    .S_sSSs
;						.SS~SSSSS   .SS~SSSSS   .SS~S*S~SS.  .SS~YS%%b
;						S%S   SSSS  S%S   SSSS  S%S `Y' S%S  S%S   `S%b
;						S%S    S%S  S%S    S%S  S%S     S%S  S%S    S%S
;						S%S SSSS%S  S%S SSSS%S  S%S     S%S  S%S    d*S
;						S&S  SSS%S  S&S  SSS%S  S&S     S&S  S&S   .S*S
;						S&S    S&S  S&S    S&S  S&S     S&S  S&S_sdSSS
;						S&S    S&S  S&S    S&S  S&S     S&S  S&S~YSSY    	$$\    $$\  $$$$$$\
;						S*S    S&S  S*S    S&S  S*S     S*S  S*S         	$$ |   $$ |$$  __$$\
;						S*S    S*S  S*S    S*S  S*S     S*S  S*S         	$$ |   $$ |\__/  $$ |
;						S*S    S*S  S*S    S*S  S*S     S*S  S*S         	\$$\  $$  | $$$$$$  |
;						SSS    S*S  SSS    S*S  SSS     S*S  S*S         	 \$$\$$  / $$  ____/
;						       SP          SP           SP   SP          	  \$$$  /  $$ |
;						       Y           Y            Y    Y    	   		   \$  /   $$$$$$$$\
;																				\_/    \________|
;
;==================================================================================================
;
;	Filename: 				.au3
;	Description:
;==================================================================================================
;
;	Author: 				Brett Francis
;	AutoIt Forums Alias: 	BrettF
;	Email: 					francisb[at]student[dot]jpc[dot]qld[dot]edu[dot]au
;
;==================================================================================================
;											Changelog
;==================================================================================================
;				- 2.0.0.2
;					- Initial version.
;
;==================================================================================================
;									This file is part of AAMP.
;		AAMP is free software: you can redistribute it and/or modify
;		it under the terms of the GNU General Public License as published by
;		the Free Software Foundation, either version 3 of the License, or
;		(at your option) any later version.
;
;		AAMP is distributed in the hope that it will be useful,
;		but WITHOUT ANY WARRANTY; without even the implied warranty of
;		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;		GNU General Public License for more details.
;
;		You should have received a copy of the GNU General Public License
;		along with AAMP.  If not, see <http://www.gnu.org/licenses/>.
;
;==================================================================================================

;==================================================================================================
;									Start Document Contents
;==================================================================================================

; Additional BASS_SetConfig options
Global Const $BASS_CONFIG_MP4_VIDEO = 0x10700 ; play the audio from MP4 videos

; Additional tags available from BASS_StreamGetTags
Global Const $BASS_TAG_MP4 = 7       ; MP4/iTunes metadata

Global Const $BASS_AAC_DOWNMATRIX = 0x400000  ; downmatrix to stereo

; BASS_CHANNELINFO type
Global Const $BASS_CTYPE_STREAM_AAC = 0x10B00
Global Const $BASS_CTYPE_STREAM_MP4 = 0x10B01

; BASS_Set/GetConfig options
Global Const $BASS_CONFIG_AC3_DYNRNG = 0x10001

; Additional BASS_AC3_StreamCreateFile/User/URL flags
Global Const $BASS_AC3_DYNAMIC_RANGE = 0x800     ; enable dynamic range compression

; BASS_CHANNELINFO type
Global Const $BASS_CTYPE_STREAM_AC3 = 0x11000


; BASS_CHANNELINFO type
Global Const $BASS_CTYPE_STREAM_ALAC = 0x10E00

; Additional error codes returned by BASS_ErrorGetCode
Global Const $BASS_ERROR_WMA_LICENSE = 1000     ; the file is protected
Global Const $BASS_ERROR_WMA = 1001             ; Windows Media (9 or above) is not installed
Global Const $BASS_ERROR_WMA_WM9 = $BASS_ERROR_WMA
Global Const $BASS_ERROR_WMA_DENIED = 1002      ; access denied (user/pass is invalid)
Global Const $BASS_ERROR_WMA_INDIVIDUAL = 1004  ; individualization is needed

; Additional BASS_SetConfig options
Global Const $BASS_CONFIG_WMA_PRECHECK = 0x10100
Global Const $BASS_CONFIG_WMA_PREBUF = 0x10101
Global Const $BASS_CONFIG_WMA_BASSFILE = 0x10103
Global Const $BASS_CONFIG_WMA_VIDEO = 0x10105
Global Const $BASS_CONFIG_WMA_NETSEEK = 0x10104

; additional WMA sync types
Global Const $BASS_SYNC_WMA_CHANGE = 0x10100
Global Const $BASS_SYNC_WMA_META = 0x10101

; additional BASS_StreamGetFilePosition WMA mode
Global Const $BASS_FILEPOS_WMA_BUFFER = 1000 ; internet buffering progress (0-100%)

; Additional flags for use with BASS_WMA_EncodeOpenFile/Network/Publish
Global Const $BASS_WMA_ENCODE_STANDARD = 0x2000 ; standard WMA
Global Const $BASS_WMA_ENCODE_PRO = 0x4000      ; WMA Pro
Global Const $BASS_WMA_ENCODE_24BIT = 32768     ; 24-bit
Global Const $BASS_WMA_ENCODE_SCRIPT = 0x20000  ; set script (mid-stream tags) in the WMA encoding

; Additional flag for use with BASS_WMA_EncodeGetRates
Global Const $BASS_WMA_ENCODE_RATES_VBR = 0x10000 ; get available VBR quality settings

; WMENCODEPROC "type" values
Global Const $BASS_WMA_ENCODE_HEAD = 0
Global Const $BASS_WMA_ENCODE_DATA = 1
Global Const $BASS_WMA_ENCODE_DONE = 2

; BASS_WMA_EncodeSetTag "type" values
Global Const $BASS_WMA_TAG_ANSI = 0
Global Const $BASS_WMA_TAG_UNICODE = 1
Global Const $BASS_WMA_TAG_UTF8 = 2

; BASS_CHANNELINFO type
Global Const $BASS_CTYPE_STREAM_WMA = 0x10300
Global Const $BASS_CTYPE_STREAM_WMA_MP3 = 0x10301

; Additional BASS_ChannelGetTags types
Global Const $BASS_TAG_WMA = 8 ; WMA header tags : series of null-terminated UTF-8 strings
Global Const $BASS_TAG_WMA_META = 11 ; WMA mid-stream tag : UTF-8 string
