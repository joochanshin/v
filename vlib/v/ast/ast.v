// Copyright (c) 2019 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module ast

import (
	v.token
	v.types
)

pub type Expr = BinaryExpr | UnaryExpr | IfExpr | StringLiteral | IntegerLiteral |
FloatLiteral | Ident | CallExpr | BoolLiteral | StructInit | ArrayInit

pub type Stmt = VarDecl | FnDecl | Return | Module | Import | ExprStmt | AssignStmt |
ForStmt | StructDecl
// Stand-alone expression in a statement list.
pub struct ExprStmt {
pub:
	expr Expr
}

pub struct IntegerLiteral {
pub:
	val int
}

pub struct FloatLiteral {
pub:
// val f64
	val string
}

pub struct StringLiteral {
pub:
	val string
}

pub struct BoolLiteral {
pub:
	val bool
}

// module declaration
pub struct Module {
pub:
	name string
	path string
	expr Expr
}

pub struct Field {
pub:
	name string
	typ  types.Type
}

pub struct StructDecl {
pub:
	name   string
	fields []Field
	is_pub bool
}

pub struct StructInit {
pub:
	typ    types.Type
	fields []string
	exprs  []Expr
}

// import statement
pub struct Import {
pub:
	mods []string
	// expr Expr
	// imports map[string]string
}

pub struct Arg {
pub:
	typ  types.Type
	name string
}

pub struct FnDecl {
pub:
	name  string
	stmts []Stmt
	typ   types.Type
	args  []Arg
}

pub struct CallExpr {
pub:
	name string
	args []Expr
}

pub struct Return {
pub:
	expr Expr
}

/*
pub enum Expr {
	Binary(BinaryExpr)
	If(IfExpr)
	Integer(IntegerExpr)
}
*/

/*
pub struct Stmt {
	pos int
	//end int
}
*/


pub struct VarDecl {
pub:
	name string
	expr Expr
	typ  types.Type
}

pub struct File {
pub:
	stmts []Stmt
}

// A single identifier
pub struct Ident {
pub:
	name     string
	tok_kind token.Kind
	value    string
}

pub struct BinaryExpr {
pub:
// tok_kind token.Kind
// op    BinaryOp
	op    token.Kind
	left  Expr
	// left_type Type
	right Expr
	// right_type Type
}

pub struct UnaryExpr {
pub:
// tok_kind token.Kind
// op    BinaryOp
	op   token.Kind
	left Expr
}

pub struct IfExpr {
pub:
	tok_kind token.Kind
	cond     Expr
	stmts    []Stmt
	else_stmts []Stmt
}

pub struct ForStmt {
pub:
	cond  Expr
	stmts []Stmt
}

pub struct ReturnStmt {
	tok_kind token.Kind // or pos
	results  []Expr
}

pub struct AssignStmt {
pub:
	left  Expr
	right Expr
	op    token.Kind
}

pub struct ArrayInit {
pub:
	exprs []Expr
	typ   types.Type
}

// string representaiton of expr
pub fn (x Expr) str() string {
	match x {
		BinaryExpr {
			return '(${it.left.str()} $it.op.str() ${it.right.str()})'
		}
		UnaryExpr {
			return it.left.str() + it.op.str()
		}
		IntegerLiteral {
			return it.val.str()
		}
		IntegerLiteral {
			return '"$it.val"'
		}
		else {
			return ''
		}
	}
}

pub fn (node Stmt) str() string {
	match node {
		VarDecl {
			return it.name + ' = ' + it.expr.str()
		}
		ExprStmt {
			return it.expr.str()
		}
		FnDecl {
			return 'fn ${it.name}() { $it.stmts.len stmts }'
		}
		else {
			return '[unhandled stmt str]'
		}
	}
}

/*
enum BinaryOp {
	sum
	difference
	product
	quotient
	remainder
	bitwise_and
	bitwise_or
	bitwise_xor
	left_shift
	right_shift

	equality
	inequality
	less_than
	less_than_or_equal
	more_than
	more_than_or_equal

	in_check

	//These are suffixed with `bool` to prevent conflict with the keyword `or`
	and_bool
	or_bool
}
*/
