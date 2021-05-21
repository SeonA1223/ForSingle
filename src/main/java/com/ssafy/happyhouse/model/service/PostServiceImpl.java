package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.dao.PostDao;
import com.ssafy.happyhouse.model.dto.PostDto;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int registPost(PostDto post) {
		return sqlSession.getMapper(PostDao.class).registPost(post);
	}

	@Override
	public List<PostDto> getPostList() {
		return sqlSession.getMapper(PostDao.class).getPostList();
	}

	@Override
	public PostDto getPost(int num) {
		return sqlSession.getMapper(PostDao.class).getPost(num);
	}

	@Override
	@Transactional
	public int updateViews(int num) {
		int views = sqlSession.getMapper(PostDao.class).getViews(num);
		return sqlSession.getMapper(PostDao.class).addViews(num, views + 1);
	}

	@Override
	public int updatePost(PostDto post) {
		return sqlSession.getMapper(PostDao.class).updatePost(post);
	}

	@Override
	public int updateAnsnwernum(int num, int answernum) {
		return sqlSession.getMapper(PostDao.class).updateAnswernum(num, answernum);
	}
	
	@Override
	public int removeAnswernum(int num) {
		return sqlSession.getMapper(PostDao.class).removeAnswernum(num);
	}
	
	@Override
	public int removePost(int num) {
		return sqlSession.getMapper(PostDao.class).removePost(num);
	}

}
