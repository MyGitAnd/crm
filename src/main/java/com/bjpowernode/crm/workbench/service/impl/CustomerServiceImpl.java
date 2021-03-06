package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.StyleSet;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.base.Contacts;
import com.bjpowernode.crm.workbench.base.Customer;
import com.bjpowernode.crm.workbench.base.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.Transaction;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerRemarkMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.mapper.TransactionMapper;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {
    //注入mapper层
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    @Autowired
    private TransactionMapper transactionMapper;

    @Autowired
    private ContactsMapper contactsMapper;

//模糊查询
    @Override
    public PageInfo<Customer> selectCustomer(Integer page, Integer pageSize,Customer customer) {
        Example example = new Example(Customer.class);
        Example.Criteria criteria = example.createCriteria();
        if (StrUtil.isNotEmpty(customer.getName())){
            criteria.andLike("name","%" + customer.getName() + "%");
        }
        //查询所有者
        if (StrUtil.isNotEmpty(customer.getOwner())){
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name","%" + customer.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (User user : users) {
                list.add(user.getId());
            }
            criteria.andIn("owner",list);
        }
        //查询公司座机
        if (StrUtil.isNotEmpty(customer.getPhone())){
            criteria.andLike("phone","%" + customer.getPhone() + "%");
        }

        //查询公司网站
        if (StrUtil.isNotEmpty(customer.getWebsite())){
            criteria.andLike("website","%" + customer.getWebsite() + "%");
        }

        PageHelper.startPage(page,pageSize);
        List<Customer> customers = customerMapper.selectByExample(example);
        for (Customer customer1 : customers) {
            User user = userMapper.selectByPrimaryKey(customer1.getOwner());
            customer1.setOwner(user.getName());
        }
        PageInfo<Customer> pageInfo = new PageInfo(customers);

        return pageInfo;
    }
    //查询所有所有者
    @Override
    public List<User> users() {
        List<User> users = userMapper.selectAll();
        return users;
    }

    //添加和修改
    @Override
    public ResultVo insertAndUpdateCustomer(Customer customer,User user) {
        ResultVo resultVo = new ResultVo();
        if (customer.getId()!= null){
            //修改的
            customer.setEditBy(user.getName());
            customer.setEditTime(DateTimeUtil.getSysTime());
            int count = customerMapper.updateByPrimaryKey(customer);
            if (count==0){
                throw new CrmException(CrmEnum.Customer_update_edit);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改用户信息成功!");
        }else {
            //添加的
            customer.setId(UUIDUtil.getUUID());
            customer.setCreateBy(user.getName());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmEnum.Customer_insert_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("添加用户信息成功!");
        }
        return resultVo;
    }
    //查询修改的方法
    @Override
    public Customer selectCustomerORId(String id) {
        return customerMapper.selectByPrimaryKey(id);
    }


    //删除的方法
    @Override
    public ResultVo deleteCustomers(String ids) {
        ResultVo resultVo = new ResultVo();
        Example example = new Example(Customer.class);
        Example.Criteria criteria = example.createCriteria();
        List<String> list = new ArrayList<>();
        String[] split = ids.split(",");
        for (String id : split) {
            list.add(id);
        }
        criteria.andIn("id",list);
        int count = customerMapper.deleteByExample(example);
        if (count==0){
            throw new CrmException(CrmEnum.Customer_delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功！【共删除"+count+"条记录!】");

        return resultVo;
    }

    //查询表单中的数据
    @Override
    public Customer lists(String id) {
        Customer customer = customerMapper.selectByPrimaryKey(id);
        User user = userMapper.selectByPrimaryKey(customer.getOwner());
        customer.setOwner(user.getName());

        Contacts contacts = new Contacts();
        contacts.setCustomerId(id);
        List<Contacts> select = contactsMapper.select(contacts);
        for (Contacts contacts1 : select) {
            customer.setContactsId(contacts1.getFullname()+contacts1.getAppellation());
        }
        CustomerRemark customerRemark = new CustomerRemark();
        customerRemark.setCustomerId(customer.getId());
        List<CustomerRemark> customerRemarks = customerRemarkMapper.select(customerRemark);
        for (CustomerRemark remark : customerRemarks) {
            remark.setCustomerId(customer.getName());
            User user1 = userMapper.selectByPrimaryKey(remark.getOwner());
            remark.setImg(user1.getImg());
            for (Contacts contacts1 : select) {
//            customer.setContactsId(contacts1.getFullname()+contacts1.getAppellation());
                remark.setContactsRemark(contacts1.getFullname()+contacts1.getAppellation());

            }
        }
        //把集合放到用户对象
        customer.setCustomerRemarks(customerRemarks);

        return customer;
    }
    //删除
    @Override
    public ResultVo deleteCustomer(String id) {
        ResultVo resultVo = new ResultVo();
        int count = customerMapper.deleteByPrimaryKey(id);
        if (count==0){
            throw new CrmException(CrmEnum.Customer_delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功!");

        return resultVo;
    }

    //添加备注信息
    @Override
    public ResultVo save(CustomerRemark customerRemark, User user) {
        ResultVo resultVo = new ResultVo();
        customerRemark.setId(UUIDUtil.getUUID());
        customerRemark.setImg(user.getImg());
        customerRemark.setCreateBy(user.getName());
        customerRemark.setCreateTime(DateTimeUtil.getSysTime());
        customerRemark.setOwner(user.getId());
        int count = customerRemarkMapper.insertSelective(customerRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.CustomerRemark__Insert_add);
        }
        //把UUID修改成名字
        Customer customer = selectCustomerORId(customerRemark.getCustomerId());
        customerRemark.setCustomerId(customer.getName());
        resultVo.setT(customerRemark);
        resultVo.setOk(true);
        resultVo.setMessage("添加备注信息成功!");

        return resultVo;
    }

    //修改备注信息
    @Override
    public ResultVo update(CustomerRemark customerRemark, User user) {
        ResultVo resultVo = new ResultVo();
        customerRemark.setEditBy(user.getName());
        customerRemark.setEditFlag("1");
        customerRemark.setEditTime(DateTimeUtil.getSysTime());

        int count = customerRemarkMapper.updateByPrimaryKeySelective(customerRemark);
        if (count==0){
            throw new CrmException(CrmEnum.CustomerRemark__update_update);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改备注信息成功！");

        return resultVo;
    }

    //删除备注信息
    @Override
    public ResultVo delete(String id) {
        ResultVo resultVo = new ResultVo();

        int count = customerRemarkMapper.deleteByPrimaryKey(id);
        if (count==0){
            throw new CrmException(CrmEnum.CustomerRemark__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除备注信息成功！");

        return resultVo;
    }

    //查询交易
    @Override
    public List<Transaction> selectCustTran() {
        List<Transaction> transactions = transactionMapper.selectAll();

        return transactions;
    }

    //删除交易
    @Override
    public ResultVo deleteContactsTran(String id) {
        ResultVo resultVo = new ResultVo();
        int count = transactionMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.CustomerTran__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除交易成功!");
        return resultVo;
    }

    //查询联系人
    @Override
    public List<Contacts> selectContactsCustomer() {

        List<Contacts> contacts = contactsMapper.selectAll();
        for (Contacts contact : contacts) {
            Customer customer = customerMapper.selectByPrimaryKey(contact.getCustomerId());
            contact.setCustomerId(customer.getName());
            contact.setFullname(contact.getFullname()+contact.getAppellation());
        }

        return contacts;
    }

    //删除联系人
    @Override
    public ResultVo deleteContacts(String id) {
        ResultVo resultVo = new ResultVo();
        int count = contactsMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.CustomerContacts__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除联系人成功!");
        return resultVo;
    }
    //添加联系人
    @Override
    public ResultVo addContactsCustomer(Contacts contacts, User user) {
        ResultVo resultVo = new ResultVo();
        contacts.setId(UUIDUtil.getUUID());
        contacts.setEditBy(user.getName());
        contacts.setCreateTime(DateTimeUtil.getSysTime());
        //因为前端传过来的是名字，所以需要转换
        Customer customer = new Customer();
        customer.setName(contacts.getCustomerId());
        List<Customer> select = customerMapper.select(customer);
        for (Customer customer1 : select) {
            contacts.setCustomerId(customer1.getId());
        }
        int count = contactsMapper.insertSelective(contacts);
        if (count == 0){
            throw new CrmException(CrmEnum.CustomerContacts__add_add);
        }
        resultVo.setOk(true);
        resultVo.setMessage("添加联系人成功!");
        return resultVo;
    }

    //导出报表
    @Override
    public ExcelWriter exportExcel() {
        ExcelWriter writer = ExcelUtil.getWriter();
        List<Customer> customers = customerMapper.selectAll();
        for (Customer customer : customers) {
            //备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setCustomerId(customer.getId());
            List<CustomerRemark> remarks = customerRemarkMapper.select(customerRemark);
            customer.setCustomerRemarks(remarks);

            //所有者
            User user = userMapper.selectByPrimaryKey(customer.getOwner());
            customer.setOwner(user.getName());
        }
        //属性的个数
        writer.merge(Customer.index - 1,"客户报表");
        //设置字体颜色
        StyleSet styleSet = writer.getStyleSet();
        //自定义标题别名
        writer.addHeaderAlias("id", "编号");
        writer.addHeaderAlias("owner", "所有者");
        writer.addHeaderAlias("name", "名称");
        writer.addHeaderAlias("website", "网站");
        writer.addHeaderAlias("phone", "手机号");
        writer.addHeaderAlias("createBy", "创建人");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("editBy", "修改人");
        writer.addHeaderAlias("editTime", "修改时间");
        writer.addHeaderAlias("description", "描述");
        writer.addHeaderAlias("contactSummary", "联系纪要");
        writer.addHeaderAlias("nextContactTime", "下次联系时间");
        writer.addHeaderAlias("address", "地址");
        writer.addHeaderAlias("customerRemarks", "备注列表");

        writer.write(customers, true);
        return writer;
    }
}
