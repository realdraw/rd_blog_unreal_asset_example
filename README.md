# 리얼드로우의 어셋 관리 방법

```
workspace/
    prop/
        Buildings/
            Content/
                Buildings/  (실제 에셋 파일들이 있는 곳)
    scene/
        RD_SCENE_0001/
            requirements_prop.bat  (관리자 권한으로 실행하는 PowerShell 스크립트)
            requirements_prop.ps1  (실제 심볼릭 링크를 생성하는 PowerShell 스크립트)
            requirements_prop.txt  (심볼릭 링크를 걸어야 할 에셋 라이브러리 폴더의 이름을 정의)
            Content/
                ExternalAssets/ (여기에 심볼릭 링크가 생성됩니다)
                    Buildings -> workspace/prop/Buildings/Content/Buildings (실제 링크)
```


위와 같은 구조로 scene 에서 prop 에 있는 어셋을 심볼릭 링크로 연결하여 사용합니다.

클론은 C:\rd_blog_unreal_asset_example\ 폴더로 해 주셔야 합니다.
