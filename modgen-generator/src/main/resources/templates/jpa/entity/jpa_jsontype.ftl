<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@>
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	JsonbUserType.java
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
package ${package};

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;
import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.type.SerializationException;
import org.hibernate.usertype.ParameterizedType;
import org.hibernate.usertype.UserType;
import org.postgresql.util.PGobject;

public class JsonbUserType implements ParameterizedType, UserType {

  private static final ObjectMapper objectMapper = new ObjectMapper();

  public static final String JSONB_TYPE = "jsonb";
  public static final String CLASS = "CLASS";

  private JavaType jsonClassType;

  @Override
  public Class<Object> returnedClass() {
    return Object.class;
  }

  @Override
  public int[] sqlTypes() {
    return new int[]{Types.JAVA_OBJECT};
  }

  @Override
  public Object nullSafeGet(ResultSet rs, String[] names, SharedSessionContractImplementor session, Object owner)
    throws HibernateException, SQLException {
	try {
		final String json = rs.getString(names[0]);
		return json == null ? null : objectMapper.readValue(json, jsonClassType);
	} catch (IOException e) {
		throw new HibernateException(e);
	}
  }

  @Override
  public void nullSafeSet(PreparedStatement st, Object value, int index, SharedSessionContractImplementor session)
    throws HibernateException, SQLException {
    try {
		final String json = value == null ? null : objectMapper.writeValueAsString(value);
		PGobject pgo = new PGobject();
		pgo.setType(JSONB_TYPE);
		pgo.setValue(json);
		st.setObject(index, pgo);
	} catch (JsonProcessingException e) {
		throw new HibernateException(e);
	}
  }

  @Override
  public void setParameterValues(Properties parameters) {
    final String clazz = (String) parameters.get(CLASS);
    jsonClassType = objectMapper.getTypeFactory().constructFromCanonical(clazz);
  }

  @SuppressWarnings("unchecked")
  @Override
  public Object deepCopy(Object value) throws HibernateException {

    if (!(value instanceof Collection)) {
      return value;
    }

    Collection<?> collection = (Collection) value;
    Collection collectionClone = CollectionFactory.newInstance(collection.getClass());

    collectionClone.addAll(collection.stream().map(this::deepCopy).collect(Collectors.toList()));

    return collectionClone;
  }

  static final class CollectionFactory {
    @SuppressWarnings("unchecked")
    static <E, T extends Collection<E>> T newInstance(Class<T> collectionClass) {
      if (List.class.isAssignableFrom(collectionClass)) {
        return (T) new ArrayList<E>();
      } else if (Set.class.isAssignableFrom(collectionClass)) {
        return (T) new HashSet<E>();
      } else {
        throw new IllegalArgumentException("Unsupported collection type : " + collectionClass);
      }
    }
  }

  @Override
  public boolean isMutable() {
    return true;
  }

  @Override
  public boolean equals(Object objX, Object objY) throws HibernateException {
    if (objX == objY) {
      return true;
    }

    if ((objX == null) || (objY == null)) {
      return false;
    }

    return objX.equals(objY);
  }

  @Override
  public int hashCode(Object object) throws HibernateException {
    assert (object != null);
    return object.hashCode();
  }

  @Override
  public Object assemble(Serializable cached, Object owner) throws HibernateException {
    return deepCopy(cached);
  }

  @Override
  public Serializable disassemble(Object value) throws HibernateException {
    Object deepCopy = deepCopy(value);

    if (!(deepCopy instanceof Serializable)) {
      throw new SerializationException(String.format("%s is not serializable class", value), null);
    }

    return (Serializable) deepCopy;
  }

  @Override
  public Object replace(Object original, Object target, Object owner) throws HibernateException {
    return deepCopy(original);
  }
}