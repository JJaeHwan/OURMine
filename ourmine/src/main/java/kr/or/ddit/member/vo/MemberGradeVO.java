package kr.or.ddit.member.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "memberGradeId")
public class MemberGradeVO implements Serializable {
	
    // 회원 등급 ID 
    private int memberGradeId;

    // 회원 등급 
    @NotNull
    private String memberGrade;

    // 회원 등급 삭제 여부
    private boolean memberGradeRemoveWhether;

}
