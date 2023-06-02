package kr.or.ddit.alarm.service;

import java.util.List;

import kr.or.ddit.alarm.vo.AlarmVO;

public interface AlarmService {

	/**
	 *
	 * @return
	 */
	public List<AlarmVO> alarmList(int receiverId);
	/**
	 *
	 * @param alarmId
	 * @return
	 */
	public AlarmVO alarmSelect(int alarmId);
	/**
	 *
	 * @param alarm
	 * @return
	 */
	public int insertAlarm(AlarmVO  alarm);
	/**
	 *
	 * @param alarm
	 * @return
	 */
	public int updateAlarm(AlarmVO  alarm);


	/**
	 *
	 * @param alarmId
	 * @return
	 */
	public int deleteAlarm(int alarmId);

}
