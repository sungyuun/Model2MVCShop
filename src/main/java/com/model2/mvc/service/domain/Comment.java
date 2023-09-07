package com.model2.mvc.service.domain;

import java.sql.Date;

public class Comment {
	
	private int commentNo;
	private String commentContent;
	private Date regDate;
	private int recommend;
	private int prodNo;
	
	public Comment() {
		
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
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
		return "Comment [commentNo=" + commentNo + ", commentContent=" + commentContent + ", createAt=" + regDate
				+ ", recommend=" + recommend + "]";
	}
	
	
}
