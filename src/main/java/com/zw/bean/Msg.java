package com.zw.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //状态码：100=成功  200=失败
    private int code;
    //返回的消息
    private String msg;
    //包装结果集
    private Map<String,Object> extend = new HashMap<>();
    //返回成功
    public static Msg success(){
        Msg result=new Msg();
        result.setCode(100);
        result.setMsg("返回成功");
        return result;
    }
    //返回失败
    public static Msg fail(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMsg("返回失败");
        return result;
    }
    //链式操作，添加pageinfo的结果集
    public Msg add(String k,Object v){
        //链式操作精髓====
        this.getExtend().put(k,v);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
