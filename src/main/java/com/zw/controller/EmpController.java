package com.zw.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zw.bean.Employee;
import com.zw.bean.Msg;
import com.zw.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/*
* URL规定：
* 1./emps{id} GET查询
* 1./emps     POST保存
* 1./emps{id} PUT修改
* 1./emps{id} DELETE删除
* */

@Controller
public class EmpController {

    @Autowired
    EmployeeService employeeService;


    //实现批量删除
    @ResponseBody
    @RequestMapping(value = "/emps/{ids}",method = RequestMethod.DELETE)
    public Msg  deleteCount(@PathVariable("ids")String ids){
        List<Integer> list=new ArrayList<>();
        String[] str_ids=ids.split("-");
        for (String str:str_ids) {
            list.add(Integer.parseInt(str));
        }
        employeeService.deleteCount(list);
        return Msg.success();
    }
    /*
    多个id以-连接
    判断传入的参数时一个还是多个：
    * 1.一个：根据ID删除数据
    * 2.多个：将id截取出来实现批量删除*/
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    public Msg deleteById(@PathVariable("id")Integer id){
        employeeService.deleteById(id);
        return Msg.success();
    }



    //GET修改时根据ID查询数据
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.selectById(id);
        return Msg.success().add("employee",employee);
    }
    /*修改完成后的更新方法
    注意：/emp/{id}传输的值要与bean中定义的id值相同才会被封装进employee对象当中
    否则：mapper根据id有选择地更新，id没穿进来，没有进行更新
    */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    //POST保存数据
    //http://localhost:8089/emps
    @ResponseBody
    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    //保存之前需进行JSR303校验，防止用户突破前端校验，破坏数据库
    public Msg saveEmployee(@Valid Employee employee, BindingResult bingResult){
        System.out.println("接受到employee的值");
        if(bingResult.hasErrors()){
            //校验失败，返回给前端失败信息
            //拿到具体的失败信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors=bingResult.getFieldErrors();
            for (FieldError fieldError: errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误的提示信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            //校验成功，进行保存
            employeeService.saveEmployee(employee);
            return Msg.success();
        }

    }

//    检查用户id是否可用
    @ResponseBody
    @RequestMapping(value = "/checkID",method = RequestMethod.GET)
    public Msg checkID(@RequestParam("id") Integer id){
        if(employeeService.checkID(id)){
            return Msg.success();
        }
        return Msg.fail();
    }



    //GET初始分页查询数据
    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    //将数据转变为json格式返回给浏览器
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //这不是一个分页查询
        //引入pageHelper分页插件
        //在查询之前只需要调用startPage，
        //传入两个参数：当前页，每页的大小
        PageHelper.startPage(pn,7);
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps=employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需将PageInfo交给页面
        //封装了详细的分页信息，包括我们查询出来的数据,连续传入5页
        PageInfo page=new PageInfo(emps,5);
        //构建通用类Msg，返回状态信息，然后链式操作结果集放入Map集合当中
        return Msg.success().add("pageInfo",page);
    }

//    @RequestMapping("/emps")
//    public  String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model){
//        //这不是一个分页查询
//        //引入pageHelper分页插件
//        //在查询之前只需要调用startPage，
//        //传入两个参数：当前页，每页的大小
//        PageHelper.startPage(pn,7);
//        //startPage紧跟的查询就是一个分页查询
//        List<Employee> emps=employeeService.getAll();
//
//        //使用PageInfo包装查询后的结果，只需将PageInfo交给页面
//        //封装了详细的分页信息，包括我们查询出来的数据,连续传入5页
//        PageInfo page=new PageInfo(emps,5);
//        model.addAttribute("PageInfo",page);
//        return "list";



    /*注意：可以人为的通过控制台突破前端校验，到达后端破坏数据库
    * 1.前端校验快速反馈，对用户友好
    * 2.重要的数据进行后端校验JSR303校验
    * 3.前端校验防君子，后端校验防小人
    * 4.导入jsr303校验的jar包Hibernate-Validator*/

    }

