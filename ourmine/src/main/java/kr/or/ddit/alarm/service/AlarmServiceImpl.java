package kr.or.ddit.alarm.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.ui.AlarmSendUtil;
import lombok.RequiredArgsConstructor;



@Service
@RequiredArgsConstructor
@Transactional
public class AlarmServiceImpl implements AlarmService{

	private final AlarmDAO alarmDAO;

	@Override
	@Transactional(readOnly = true)
	public List<AlarmVO> alarmList(int receiverId) {

		return alarmDAO.alarmList(receiverId);
	}

	@Override
	@Transactional(readOnly = true)
	public AlarmVO alarmSelect(int alarmId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertAlarm(AlarmVO alarm) {
		// TODO Auto-generated method stub



		return 0;
	}

	@Override
	public int updateAlarm(AlarmVO alarm) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAlarm(int alarmId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
