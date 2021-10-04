package com.zw.bean;

import org.springframework.format.annotation.DateTimeFormat;


public class Department {
    public Department(){};
    public Department(Integer id,Integer height,Integer weight){
        this.id=id;
        this.height=height;
        this.weight=weight;
    };

    private Integer id;

    private Integer height;

    private Integer weight;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public Integer getWeight() {
        return weight;
    }
    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    @Override
    public String toString() {
        return "Department{" +
                "id=" + id +
                ", height=" + height +
                ", weight=" + weight +
                '}';
    }
}
