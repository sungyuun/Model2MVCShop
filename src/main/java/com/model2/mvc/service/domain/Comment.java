package com.model2.mvc.service.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class Comment {
	
	private String userId;
	private int commentNo;
	private String commentContent;
	private String password;
	private Timestamp regDate;
	private int recommend;
	private int prodNo;
	
	public Comment() {
		
	}

	

	public String getUserId() {
		return userId;
	}



	public void setUserId(String userId) {
		this.userId = userId;
	}



	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		System.out.println("인트 들어옴");
		this.commentNo = commentNo;
	}
	public void setCommentNo(Integer commentNo) {
		System.out.println("인테저 들어옴");
		this.commentNo = (int)commentNo;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	

	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public Timestamp getRegDate() {
		return regDate;
	}



	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}



	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}



	@Override
	public String toString() {
		return "Comment [userId=" + userId + ", commentNo=" + commentNo + ", commentContent=" + commentContent
				+ ", password=" + password + ", regDate=" + regDate + ", recommend=" + recommend + ", prodNo=" + prodNo
				+ "]";
	}




	
	
	
}
