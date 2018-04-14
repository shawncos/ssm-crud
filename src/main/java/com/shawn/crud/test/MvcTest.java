package com.shawn.crud.test;


import com.github.pagehelper.PageInfo;
import com.shawn.crud.bean.Employee;
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
 * 使用spring 测试请求模块
 *
 *
 * */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {

    //传入springmvcd的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

        //请求成功以后，请求域中会有pageInfo,可以取出，进行验证
        MockHttpServletRequest request = result.getRequest();

        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码：" + pi.getPageNum());
        System.out.println("总页码：" + pi.getPages());
        System.out.println("总记录数：" + pi.getTotal());
        System.out.println("需要在页面连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.print("" + i);

        }

        //获取员工数据
        List<Employee> list = pi.getList();
        for (Employee employee : list) {
            System.out.println("id= "+employee.getEmpId()+" 姓名： "+employee.getEmpName()+"性别： "+employee.getGender());
        }

    }
}
