﻿using System.CodeDom.Compiler;

namespace T4SQL
{
	public interface ITemplate
	{
		TemplateContext Context
		{
			get;
			set;
		}

		#region Auto-generated by TextTemplatingFilePreprocessor

		CompilerErrorCollection Errors
		{
			get;
		}

		void Error(string message);

		string TransformText();

		#endregion
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Copyright 2013 Abel Cheng
//	This source code is subject to terms and conditions of the Apache License, Version 2.0.
//	See http://www.apache.org/licenses/LICENSE-2.0.
//	All other rights reserved.
//	You must not remove this notice, or any other, from this software.
//
//	Original Author:	Abel Cheng <abelcys@gmail.com>
//	Created Date:		‎March ‎08, ‎2013, ‏‎12:18:21 PM
//	Primary Host:		http://t4sql.codeplex.com
//	Change Log:
//	Author				Date			Comment
//
//
//
//
//	(Keep code clean rather than complicated code plus long comments.)
//
////////////////////////////////////////////////////////////////////////////////////////////////////