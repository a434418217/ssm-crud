package code.test;

import code.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:spring/spring-mybatis.xml","classpath:spring/spring-mvc.xml"})
public class MvcPageTest {
    @Autowired
    WebApplicationContext context;      //要添加@WebAppxxxxx注解

    //虚拟请求
    MockMvc mockMvc;
    //使用得先进行设置
    @Before
    public void initMockMvc(){
         mockMvc = MockMvcBuilders.webAppContextSetup(context).build();

    }

    @Test
    public void pageTest() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("page", "10")).andReturn();
        //获取请求域的值
        MockHttpServletRequest resultRequest = result.getRequest();
        PageInfo pageinfo = (PageInfo) resultRequest.getAttribute("pageInfo");
        System.out.println("当前页码"+pageinfo.getPageNum());
        System.out.println("总页码"+pageinfo.getPages());
        System.out.println("总记录数"+pageinfo.getTotal());
        System.out.println("连续显示的页码:");
        int[] nums = pageinfo.getNavigatepageNums();
        for (int i: nums
             ) {
            System.out.print("    "+i);
        }

        //获取员工数据
        List<Employee> list = pageinfo.getList();
        for (Employee emps:list
             ) {
            System.out.println(emps);
        }
    }
}
