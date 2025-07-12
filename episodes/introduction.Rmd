---
title: "A first LambdaNative App"
teaching: 10
exercises: 1
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do you create a LambdaNative Application?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Create a LambdaNative Application

::::::::::::::::::::::::::::::::::::::::::::::::

## Steps

Make your own copy of the
[template repository](https://github.com/bkmgit/LambdaNativeQuickStart)

Wait for the build to complete, check the build output.  Download
the Android apk file that has been built. Install it on your Android
device and try to run it.  You will need to unzip it first and may
need to enable developer permissions on your Android device to be
able to install the apk file directly.

::::::::::::::::::::::::::::::::::::: challenge

## Challenge 1: Can you do it?

The workflow builds a demonstration calculator application. What other
applications are available in the
[LambdaNative apps folder](https://github.com/part-cw/lambdanative/tree/master/apps)?

Which of these applications are listed in the
[LambdaNative README](https://github.com/part-cw/lambdanative/blob/master/README.md)
as demonstration programs?


:::::::::::::::::::::::: solution

The Calculator, LineDrop and uSquish applications are listed as demonstration
applications

:::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: challenge

## Challenge 2: Can you do it?

Modify the workflow to build one of the other demonstration applications.


:::::::::::::::::::::::: solution

Within `.github/workflows/build.yml` replace `./configure Calculator` with either
`./configure LineDrop` or `./configure uSquish`.

:::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::

Update `HelloLambdaNative/main.scm` to contain:

```scheme
;; SPDX identifier MIT

;; hello LambdaNative example

(define gui #f)
(define introdisplay #f)

(main
;; initialization
  (lambda (w h)
    (make-window 320 480)
    (glgui-orientation-set! GUI_PORTRAIT)
    (set! gui (make-glgui))
    (let* ((w (glgui-width-get))
           (h (glgui-height-get)))
    (set! introdisplay (glgui-label gui 5 (- h 80) (- w 10) 60 "Hello World!" ascii_14.fnt Green))
    (glgui-widget-set! gui introdisplay 'align GUI_ALIGNCENTER)
    (glgui-widget-set! gui introdisplay 'hidden #f))
;; events
  (lambda (t x y) 
    (if (= t EVENT_KEYPRESS) (begin 
      (if (= x EVENT_KEYESCAPE) (terminate))))
    (glgui-event gui t x y))
;; termination
  (lambda () #t)
;; suspend
  (lambda () (glgui-suspend))
;; resume
  (lambda () (glgui-resume))
)

;; eof
```

Modify  `.github/workflows/build.yml` to replace

```yaml
    - name: linux builds
      working-directory: lambdanative
      run: |
       ./configure Calculator
       make
    - name: android builds
      working-directory: lambdanative
      run: |
       # Fedora only provides Python3
       sed -i 's/python/python3/g' targets/android/check-tools
       # Make directory to avoid errors during build
       mkdir -p /home/build/.cache/lambdanative/android/support
       ./configure Calculator android debug
       make
```

by

```yaml
    - name: copy source
      run: |
       cp -r HelloLambdaNative lambdanative/apps
    - name: android builds
      working-directory: lambdanative
      run: |
       # Fedora only provides Python3
       sed -i 's/python/python3/g' targets/android/check-tools
       # Make directory to avoid errors during build
       mkdir -p /home/build/.cache/lambdanative/android/support
       ./configure HelloLambdaNative android debug
       make
```

Wait for the pipeline to complete and then download the artifact
and try to run it.



::::::::::::::::::::::::::::::::::::: keypoints 

- It is possible to use the cloud to build an Android application
- The LambdaNative framework enables rapid application development

::::::::::::::::::::::::::::::::::::::::::::::::

