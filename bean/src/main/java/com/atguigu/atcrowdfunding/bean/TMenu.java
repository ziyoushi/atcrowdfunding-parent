package com.atguigu.atcrowdfunding.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class TMenu implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;

    private Integer pid;

    private String name;

    private String icon;

    private String url;
    
    private List<TMenu> childs = new ArrayList<TMenu>();

    public List<TMenu> getChilds() {
		return childs;
	}

	public void setChilds(List<TMenu> childs) {
		this.childs = childs;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
}