# Wow Addon Text To Color Telemetry

Let's create and addon that export text as color for Webcam Telemetry



⬇️ Create a git on GitHub to save your code and update it accross computers

⬇️ Create a  `.toc` file to say "This folder is an addons

⬇️ Here is a example of a toc file

``` toc
## Interface: 110100, 11507
## Title: |cff0070DE[Color Telemetry |r
## Author: Éloi Strée
## Version: 2025.7.27
## Notes: Allows to export telemetry from color block with Webcam.
## Notes-url: https://github.com/EloiStree/2025_07_23_WowAddonTextToColorTelemetry
## DefaultState: enabled
## SavedVariables: MEMO_AM_SAVED_TEXT_VARIABLE
## Fonts/BarcodeFont.ttf

STATIC_FUNCTION.lua
STATIC_VARIABLE.lua
MAIN_CODE.lua

```

⬇️ QR code would be a solution if addons could draw pixel but they are something close the bar code:  
```
a b c d e  f g h  i j k l  m n o p q r s t u v w x  y z 
1 2 3 4 5 6 7 8 9 0 $ . % * + - / 
```  
Download it here: [https://fonts2u.com/free-3-of-9-regular.font](https://fonts2u.com/free-3-of-9-regular.font) 


⬇️ Create Fonts folder for the `.ttf`


```
git clone https://github.com/EloiStree/2025_07_23_WowAddonTextToColorTelemetry ColorTelemetry
```


> Note: Working on this topic, remind me of this episode [Leran the ancient](https://www.youtube.com/watch?v=Y6lOQUo-su4)


Sure! Here's a clearer and more polished version of your text:

---

**Post-Mortem of a Concept**
I originally wanted to represent a byte using 8 square characters rendered via a font. However, characters with ASCII codes from 8 to 14 and 127 caused issues—they aren't simply displayed but are interpreted as control actions.

Additionally, while ASCII technically includes 256 characters, in some environments like World of Warcraft, only the first 127 are reliably usable. Going beyond character code 130 tends to break compatibility.

In response to this limitation, I created a custom base-58 encoding scheme. It represents values using nearly 7 bits (up to `0101111`) and adds `_` and `|` to complete the character set.

Here's the full character set I used:

```
0 1 2 3 4 5 6 7 8 9 
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 
a b c d e f g h i j k l m n o p q r s t u v w x y z 
_ |
```


<img width="1324" height="208" alt="image" src="https://github.com/user-attachments/assets/25a14d02-3184-41ce-a8c6-30ac1ef800b2" />
<img width="1614" height="168" alt="image" src="https://github.com/user-attachments/assets/53d1e35a-6137-4957-b563-bffb06fe5713" />

<img width="1324" height="808" alt="image" src="https://github.com/user-attachments/assets/363846d0-93d3-4aa7-b4ae-8464667dfcb3" />

<img width="1321" height="534" alt="image" src="https://github.com/user-attachments/assets/0cef441c-546d-4816-9f8b-a3bf4e02d39a" />



