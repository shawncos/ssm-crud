package com.shawn.crud.test;


import com.shawn.crud.bean.Department;
import com.shawn.crud.dao.DepartmentMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/*
* 测试dao层
*使用spring的项目ng的单元测试，自动注入我们所需要的组件‘
* 1.导入SpringTest
* 2.ContextConfiguration指定spring配置文件的位置
* 3.直接
* */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Test
    public void TestCRUD() {
        //System.out.println(departmentMapper);
        departmentMapper.insertSelective(new Department(null,"售后部"));
        departmentMapper.insertSelective(new Department(null,"服务部"));

    }
}
