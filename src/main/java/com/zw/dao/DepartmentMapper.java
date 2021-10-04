package com.zw.dao;

import com.zw.bean.Department;
import com.zw.bean.Employee;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface DepartmentMapper {
    Department selectByPrimaryKey(Integer id);

    List<Department> selectAllByPrimaryKey(Integer id);

//    在查询部门表的1同时也可以查询员工表信息
    Department selectByPrimaryKeyWithEmp(Integer id);
    List<Department> selectAllByPrimaryKeyWithEmp(Integer id);

    int deleteByPrimaryKey(Integer id);

    int insert(Department record);

    int insertSelective(Department record);


    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
}