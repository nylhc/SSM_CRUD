import com.github.pagehelper.PageInfo;
import com.zw.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/*
* 使用spring测试模板提供的测试功能
* */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MVCTest {
    //传入springmvc的ioc容器
    @Autowired
    WebApplicationContext context;
    //虚拟mvc，来获取处理结果
    MockMvc mockMvc;
    @Before
    public void initMockMvc(){
        mockMvc=MockMvcBuilders.webAppContextSetup(context).build();

    }
    @Test
    public void testpage() throws Exception {
        //模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "10")).andReturn();
        //请求成功后
        MockHttpServletRequest request =result.getRequest();
        PageInfo pi=(PageInfo) request.getAttribute("PageInfo");
        System.out.println("当前页码"+pi.getPageNum());
        System.out.println("总页码"+pi.getPages());
        System.out.println("总记录数"+pi.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int []nums=pi.getNavigatepageNums();
        for (int i:nums) {
            System.out.println(" "+i);
        }
        List<Employee> list=pi.getList();
        for (Employee employee:list
             ) {
            System.out.println("id:"+employee.getId()+"===>name:"+employee.getName()+"===>sex:"+employee.getSex()+"===>age:"+employee.getAge());
        }


    }
}

