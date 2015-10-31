#!/usr/bin/ruby 
# 
# complie.rb
# zruibin.asia
#
# Created by Ruibin.Chow on 15/10/30.
# Copyright (c) 2015年 www.zruibin.asia. All rights reserved.

# 将指定的SRC目录下的EMACScript 6脚本能过babel批量转换成EMACScript 5的
# 前提条件是有安装babel-transpiler
# 命令：$ gem install babel-transpiler

require 'babel/transpiler'
require 'find'
require 'fileutils'

SRC = './src'
OUTDIR = './out'

def complieTheES6File(fileName)
    code = File.read(fileName)
    code = Babel::Transpiler.transform(code)["code"]
    return code
end

def wirteToES5File(fileName, content)
    fileName.gsub!(Regexp.new(SRC), OUTDIR)
    puts fileName
    f = open(fileName,"w")
    f.puts content
end

def makeTheDir(dir)
    if dir != SRC
        dir.gsub!(Regexp.new(SRC), OUTDIR)
        # puts dir
        Dir.mkdir(dir)
    end
end

  
 def complieES6ToES5(path)
    Find.find(path) do |f|  
        type = "File" if File.file?(f)
        type  = "Dir " if File.directory?(f)
        if type != "File" && type != "Dir "
          type = "   ?"
        end
        if type != 'File'
            # puts "#{type}: #{f}" 
            makeTheDir(f)
        end
        if type == 'File'
            # puts "#{type}: #{f}" 
            content = complieTheES6File(f)
            wirteToES5File(f, content)
        end
    end 
end
 

FileUtils.rm_rf(OUTDIR)
Dir.mkdir(OUTDIR)
complieES6ToES5(SRC)



























