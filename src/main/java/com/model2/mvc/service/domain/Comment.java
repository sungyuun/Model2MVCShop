package com.model2.mvc.service.domain;

import java.sql.Date;

public class Comment {
	
	private int commentNo;
	private String commentContent;
	private Date createAt;
	private int recommend;
	
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

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", commentContent=" + commentContent + ", createAt=" + createAt
				+ ", recommend=" + recommend + "]";
	}
	
	
}
