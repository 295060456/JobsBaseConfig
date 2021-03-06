#! /bin/sh

##echo "\n ****** begin ****** \n"
## 获取当前的相对路径
#basedir=`cd $(dirname $0); pwd -P`
##echo "当前的相对路径: $basedir"
## 只需要修改这个内容就行，其他的内容不需要改动
#git_commit_des="JobsBaseConfig"
## 文件名（不含后缀名）
#file_name="JobsBaseConfig"
## 获取到的文件路径
#file_path=$basedir/$file_name
## 文件后缀名
#file_extension="podspec"
## 定义pod文件名称
#pod_file_name=${file_name}
## 查找 podspec 的版本
#search_str="s.version"
## 读取podspec的版本
#podspec_version=""
##定义了要读取文件的路径
#my_file="${pod_file_name}"
#
## 参数1: 路径；参数2: 文件后缀名
#function getFileAtDirectory(){
#    for element in `ls $1`
#    do
#        dir_or_file="/"$element
##        echo "dir_or_file: ${dir_or_file}"
#
#        if [ ! -d $dir_or_file ];then
#            file_extension=${dir_or_file##*.}
#
#            if [ "$file_extension" == "$2" ];then
#            	echo $dir_or_file "是" $file_extension "文件"
#            	file_path=$dir_or_file
#            	file_name=$element
#            fi
#        fi
#    done
#}
#
#getFileAtDirectory $basedir $file_extension

#echo "\n -------------"
#echo "\n file_path: ${file_path}"
#echo "\n file_name: ${file_name}"
#echo "\n podspec文件📃: ${dir_or_file}"
#echo "\n ---- 读取podspec文件内容 begin ---- \n"
#
#echo "\n pod_file_name: ${pod_file_name}"
##
## 定义pod文件名称
#pod_file_name=${file_name}
## 查找 podspec 的版本
#search_str="s.version"
## 读取podspec的版本
#podspec_version=""
##定义了要读取文件的路径
#my_file="${pod_file_name}"

#####

while read my_line
do
#输出读到的每一行的结果
    echo $my_line
#	# 查找到包含的内容，正则表达式获取以 ${search_str} 开头的内容
#	result=$(echo ${my_line} | grep "^${search_str}")
#	if [[ "$result" != "" ]];then
#   		echo "\n ${my_line} 包含 ${search_str}"
#   		# 分割字符串，是变量名称，不是变量的值; 前面的空格表示分割的字符，后面的空格不可省略
#		array=(${result// / })
#		# 数组长度
#		count=${#array[@]}
#		# 获取最后一个元素内容
#		version=${array[count - 1]}
#		# 去掉 '
#		version=${version//\'/}
#
#		podspec_version=$version
#	else
#        echo "\n ${my_line} 不包含 ${search_str}"
#	fi

done < $my_file

#echo "\n podspec_version: ${podspec_version}"

#pod_spec_name=${file_name}
#pod_spec_version=${podspec_version}
#
#echo "\n****** ${pod_spec_name} ${pod_spec_version} begin ****** \n"
#echo "\n ------ 执行 pod install ------ \n"
#echo "cd Example"
#cd Example
#echo "pod install"
#pod install
#
## 回到上级目录
#echo "cd .."
#cd ..
#
#echo "\n ------ 执行 git 本地提交代码操作 ------ \n"
## git 操作
#echo "git add ."
#git add .
#echo "git status"
#git status
#echo "git commit -m ${git_commit_des}"
#git commit -m ${git_commit_des}
#echo "\n ------ 执行 pod 本地校验 ------ \n"
## pod 本地校验
#echo "pod lib lint --allow-warnings --verbose"
#pod lib lint --allow-warnings --verbose
#echo "\n ------ 执行 git 打标签tag，并推送到远端 ------ \n"
## git推送到远端
#echo "git tag ${pod_spec_version}"
#git tag ${pod_spec_version}
#echo "git push origin master --tags"
#git push origin master --tags
#echo "\n ------ 执行 pod 远端校验 ------ \n"
## pod 远端校验
#echo "pod spec lint --allow-warnings --verbose"
#pod spec lint --allow-warnings --verbose
#echo "\n ------ 执行 pod 发布 ------ \n"
## 发布
#echo "pod trunk push --allow-warnings"
#pod trunk push --allow-warnings
#echo "\n****** ${pod_spec_name} ${pod_spec_version} end ****** \n"
#echo "****** end ******"
