package com.zw.service;

import com.zw.bean.Employee;
import com.zw.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    //初始分页查询
    public List<Employee> getAll(){
        //全部对象能返回给list集合
        return employeeMapper.selectAll();
    }

    //提交保存员工数据
    public void saveEmployee(Employee employee){

        employeeMapper.insertSelective(employee);
    }

    //检查ID是否可用
    public boolean checkID(Integer id){
        if(employeeMapper.selectByPrimaryKey(id)==null){
            return true;
        }
        return false;
    }

    //修改时根据id查询
    public Employee selectById(Integer id){
        return employeeMapper.selectByPrimaryKey(id);
    }
    //修改完成后，update
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }


    //根据ID删除
   public void  deleteById(Integer id){
       employeeMapper.deleteByPrimaryKey(id);
   }


   //根据多个id，实现批量删除
    public void deleteCount(List<Integer> list){
        for (Integer id:list) {
            employeeMapper.deleteByPrimaryKey(id);
        }
    }
}
