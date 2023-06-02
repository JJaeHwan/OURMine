package kr.or.ddit.alarm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.alarm.vo.AlarmVO;

@Mapper
public interface AlarmDAO {



	public List<AlarmVO> alarmList(int receiverId);

	public AlarmVO alarmSelect(int alarmId);

	public int insertAlarm(@Param("alarms") List<AlarmVO>  alarm);

	public int updateAlarm(AlarmVO  alarm);

	public int deleteAlarm(int alarmId);

}
