package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.neu.wms.dao.ClientMapper;
import com.neu.wms.domain.Client;
import com.neu.wms.query.ClientQuery;
import com.neu.wms.service.ClientService;

@Service
public class ClientMapperIpml implements ClientService {
	
	@Autowired
	ClientMapper clientMapper;

	@Override
	public List<Client> findByQuery(ClientQuery clientQuery) {
		return clientMapper.findByQuery(clientQuery);
	}

	@Override
	public long findCount(ClientQuery clientQuery) {
	    return clientMapper.findCount(clientQuery);
	}

	@Override
	public int add(Client client) {
	    return clientMapper.add(client);
	}

	@Override
	public int delete(int[] id) {
		return clientMapper.delete(id);
	}

	@Override
	public Client findById(int id) {
		return clientMapper.findById(id);
	}

	@Override
	public int update(Client client) {
		return clientMapper.update(client);
	}
}
