module ApplicationHelper
	#根据所在的页面返回完整的标题
	def full_title(page_title = '鲁克微博')			#定义方法,参数可选
	base_title = '鲁克微博'						#变量赋值
		if page_title.empty?						#布尔测试
			base_title 							#隐式返回值
		#	return base_title 	可省略return		
		else
			page_title + ' - ' + base_title			#字符串拼接
		end
	end
end

