package com.model2.mvc.service.comment;

public interface CommentService {

    public void addComment(Comment comment);

    public void updateComment(Comment comment);

    public void recommend(boolean click);

    public void deleteComment(Comment comment);

    public List<Comment> getCommentList(int prodNo) throws Exception;

    public int getTotalCount(Search search) throws Exception ;
}
