package kr.or.ddit.alarm.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Greeting {

    private String content;

    public Greeting() {
    }

    public Greeting(String content) {
        this.content = content;
    }
}
