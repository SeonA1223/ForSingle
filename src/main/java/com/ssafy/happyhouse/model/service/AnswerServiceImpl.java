package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;

import com.ssafy.happyhouse.model.dao.AnswerDao;
import com.ssafy.happyhouse.model.dao.PostDao;
import com.ssafy.happyhouse.model.dto.AnswerDto;

@Service
public class AnswerServiceImpl implements AnswerService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	@Transactional
	public int registAnswer(AnswerDto answer, int postnum) {
		sqlSession.getMapper(AnswerDao.class).registAnswer(answer);
		sqlSession.getMapper(PostDao.class).updateAnswernum(postnum, answer.getNum());
		return answer.getNum();
	}

	@Override
	public List<AnswerDto> getAnswerList() {
		return sqlSession.getMapper(AnswerDao.class).getAnswerList();
	}

	@Override
	public AnswerDto getAnswer(int num) {
		return sqlSession.getMapper(AnswerDao.class).getAnswer(num);
	}

	@Override
	public int updateAnswer(AnswerDto answer) {
		return sqlSession.getMapper(AnswerDao.class).updateAnswer(answer);
	}

	@Override
	@Transactional
	public int removeAnswer(int pnum) {
		int num = sqlSession.getMapper(PostDao.class).getPost(pnum).getAnswernum();
		sqlSession.getMapper(PostDao.class).removeAnswernum(pnum);
		return sqlSession.getMapper(AnswerDao.class).removeAnswer(num);
		
	}

}
