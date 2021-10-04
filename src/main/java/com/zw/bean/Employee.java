package com.zw.bean;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class Employee {
    //JSR303校验
//    @Pattern(regexp = "^[0-9]{1,9}$"
    @Min(value = 1,message = "后端校验:id格式不正确")
    private Integer id;

//    @Pattern(regexp = "^[\u4e00-\u9fa5]{1,10}$"
//            ,message = "后端校验：用户名格式不正确")
    @Length(min = 1,max = 10,message = "后端校验:用户名格式不正确" )
    private String name;

    private String sex;

    private Integer age;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
    //构造方法
    public Employee(){};
    public Employee(Integer id,String name,String sex,Integer age){
        this.id=id;
        this.name=name;
        this.sex=sex;
        this.age=age;
    };
}