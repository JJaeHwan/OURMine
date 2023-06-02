package kr.or.ddit.item.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "salesSssId")
public class ItemStatisticsVO implements Serializable {
	
	//매출통계ID
    private int salesSssId;

    //상품ID 외래키 
    private int itemId;

    //분기매출통계
    private int quarterSalesSss;
    
    //연간매출통계
    private int yearSalesSss;

}
