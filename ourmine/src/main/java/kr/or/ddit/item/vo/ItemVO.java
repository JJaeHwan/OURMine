package kr.or.ddit.item.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "itemId")
public class ItemVO implements Serializable {
	
	//상품ID
    private int itemId;

    //상품이름
    @NotNull(groups = {UpdateGroup.class,InsertGroup.class})
    private String itemName;

    //상품가격
    @NotBlank(groups = {UpdateGroup.class,InsertGroup.class})
    private int itemPrice;

    //상품내용
    @NotNull(groups = {UpdateGroup.class,InsertGroup.class})
    private String itemContent;

    //상품구독기간
    @NotNull(groups = {UpdateGroup.class, InsertGroup.class})
    private int itemDuration; 
    
    // 상품삭제여부
    private boolean itemRemove;
}
