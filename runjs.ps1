makelove lovejs
Expand-Archive -Force .\pkg\lovejs\lowrezjam-2022-lovejs.zip -DestinationPath .\pkg\lovejs\
Copy-Item .\build\index.html -Destination "pkg/lovejs/lowrezjam-2022"
python -m http.server 8000 --directory "pkg/lovejs/lowrezjam-2022"
