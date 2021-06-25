#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# See Apple "System-Declared Uniform Type Identifiers":
# https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html

duti -s org.vim.MacVim              public.text                         all
duti -s org.vim.MacVim              public.plain-text                   all
duti -s org.vim.MacVim              public.source-code                  all
duti -s org.vim.MacVim              public.assembly-source              all
duti -s org.vim.MacVim              public.c-header                     all
duti -s org.vim.MacVim              public.c-plus-plus-header           all
duti -s org.vim.MacVim              public.c-source                     all
duti -s org.vim.MacVim              public.c-plus-plus-source           all
duti -s org.vim.MacVim              public.objective-c-source           all
duti -s org.vim.MacVim              public.objective-c-plus-plus-source all
duti -s org.vim.MacVim              public.script                       all
duti -s org.vim.MacVim              public.shell-script                 all
duti -s org.vim.MacVim              public.perl-script                  all
duti -s org.vim.MacVim              public.php-script                   all
duti -s org.vim.MacVim              public.python-script                all
duti -s org.vim.MacVim              public.ruby-script                  all
duti -s org.vim.MacVim              public.xml                          all
duti -s org.vim.MacVim              com.apple.property-list             all
duti -s org.vim.MacVim              com.netscape.javascript-source      all
duti -s org.vim.MacVim              com.sun.java-source                 all
duti -s org.vim.MacVim              .S                                  all
duti -s org.vim.MacVim              .c                                  all
duti -s org.vim.MacVim              .cc                                 all
duti -s org.vim.MacVim              .conf                               all
duti -s org.vim.MacVim              .cpp                                all
duti -s org.vim.MacVim              .css                                all
duti -s org.vim.MacVim              .cu                                 all
duti -s org.vim.MacVim              .fish                               all
duti -s org.vim.MacVim              .go                                 all
duti -s org.vim.MacVim              .h                                  all
duti -s org.vim.MacVim              .java                               all
duti -s org.vim.MacVim              .js                                 all
duti -s org.vim.MacVim              .json                               all
duti -s org.vim.MacVim              .jsonnet                            all
duti -s org.vim.MacVim              .libsonnet                          all
duti -s org.vim.MacVim              .log                                all
duti -s org.vim.MacVim              .lua                                all
duti -s org.vim.MacVim              .ly                                 all
duti -s org.vim.MacVim              .m                                  all
duti -s org.vim.MacVim              .md                                 all
duti -s org.vim.MacVim              .mm                                 all
duti -s org.vim.MacVim              .php                                all
duti -s org.vim.MacVim              .pl                                 all
duti -s org.vim.MacVim              .plist                              all
duti -s org.vim.MacVim              .proto                              all
duti -s org.vim.MacVim              .py                                 all
duti -s org.vim.MacVim              .rb                                 all
duti -s org.vim.MacVim              .rst                                all
duti -s org.vim.MacVim              .s                                  all
duti -s org.vim.MacVim              .sh                                 all
duti -s org.vim.MacVim              .sql                                all
duti -s org.vim.MacVim              .swift                              all
duti -s org.vim.MacVim              .tex                                all
duti -s org.vim.MacVim              .toml                               all
duti -s org.vim.MacVim              .txt                                all
duti -s org.vim.MacVim              .ulss                               all
duti -s org.vim.MacVim              .vim                                all
duti -s org.vim.MacVim              .xml                                all
duti -s org.vim.MacVim              .yaml                               all
duti -s org.vim.MacVim              .yml                                all

duti -s com.google.Chrome           .svg                                all

duti -s com.apple.QuickTimePlayerX  public.audio                        all
duti -s com.apple.QuickTimePlayerX  public.aiff-audio                   all
duti -s com.apple.QuickTimePlayerX  public.mpeg-4-audio                 all
duti -s com.apple.QuickTimePlayerX  public.mp3                          all
duti -s com.apple.QuickTimePlayerX  com.microsoft.waveform-audio        all
duti -s com.apple.QuickTimePlayerX  .aif                                all
duti -s com.apple.QuickTimePlayerX  .aiff                               all
duti -s com.apple.QuickTimePlayerX  .m4a                                all
duti -s com.apple.QuickTimePlayerX  .m4r                                all
duti -s com.apple.QuickTimePlayerX  .mp3                                all
duti -s com.apple.QuickTimePlayerX  .wav                                all
duti -s com.apple.QuickTimePlayerX  .wave                               all
