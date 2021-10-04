import com.zw.bean.Department;
import com.zw.bean.Employee;
import com.zw.dao.DepartmentMapper;
import com.zw.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

/*    @Test
    public void testCrud(){
        //  1.spring-mybatis整合之后如何测试SQL
        // 创建ioc容器,通过ioc容器获取dao的代理对象
        ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
        Department  department=bean.selectByPrimaryKey(1);
        System.out.println(department);
    }
*/

/*
推荐spring的项目使用spring的单元测试,可以自动注入我们需要的组件
导入Spring-Test依赖模块
@ContextConfiguration指定Spring配置文件的位置
直接@autorwired要使用的组件即可
*/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class SsmSqlTest {

    @Resource
    DepartmentMapper  departmentMapper;
    @Autowired
    SqlSession sqlSession;
//    spring整合之后的单元测试::
    @Test
    public void testCrud1(){

        System.out.println(departmentMapper);
//        departmentMapper.deleteByPrimaryKey(1);
//     批量操作
        EmployeeMapper employeeMapper=sqlSession.getMapper(EmployeeMapper.class);
//        循环插入一千条数据
//        for(int i=0;i<1000;i++){
//           String uuid=UUID .randomUUID().toString().substring(0,5)+i;
//           mapper.insert(new Employee(null,uuid,"男",i+10));
//      }
        //select*返回的数据是对象的集合
        //List<Employee> list=employeeMapper.selectAll();
        List<Employee> list=employeeMapper.selectAll();
        for (Employee i:list) {
            System.out.println("name： "+i.getName());
        }
    }
}
