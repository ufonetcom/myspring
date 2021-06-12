package com.doom.exception;

//SuppressWarnings어노테이션은 해당 Exciption을 받아 오류(노란줄 등)등을 억제(무시) 시키는 기능을 한다.
//"serial"은 직렬화 가능 클래스에 대한 누락된 serialVersionUID 필드와 관련된 경고를 억제.
@SuppressWarnings("serial")
public class AttachFileException extends RuntimeException{
    public AttachFileException(String message) {
        super(message);
    }

    public AttachFileException(String message, Throwable cause) {
        super(message, cause);
    }
}
