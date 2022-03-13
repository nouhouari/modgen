#### Model generator project

The model generator project is a framework for generating text file from UML class diagrams.

This project use the ECore Eclipse plugin to design the UML model and Apache FreeMarker template engine.

You can find more documentation about 

- ECore tool at [http://www.eclipse.org/ecoretools/overview.html](http://www.eclipse.org/ecoretools/overview.html)
- FreeMarker at [http://freemarker.org/](http://freemarker.org/)

## Supported field types
- byte
- short
- int
- long
- float
- double
- string
- boolean
- Date
- Enums


### Attribute and Class naming convention

__WARNING__ : The attributes and classes should follow the camelcase naming standard.

Avoid also to use reserved Java, Protobuf, HTML or Typescript or any programming language words.


### Annotations

The generator use ECore annotation to share model parameters to the generators. 

##### 1. Generator Specific Annotations
Below is the list of the supported annotations :

- __PK__   : Primary key __attribute__. Only int, long and String types are supported.
- __AUTO__ : For a primary key __attribute__, indicates that the key needs to be generated. For int and long, it will be a serial. For String a UUID.
- __QUERY__ : Indicates that the __attribute__ can be query in the search. Add __EQUAL__ to query of type string to search the exact value instead of wildcard
- __LONG__ : For a long String __attribute__ to specify the length of the String, use LENGHT detail to specify the length. (default: 10000) 
- __ListHide__ : Indicates that the __attribute__ will not be visible in the list view.
- __SORT__ : Indicates that the __attribute__ can be used to sort the entity
- __LOCATION__ : Used for a String __attribute__, the field will be considered as a JTS geometry. Use only when you plan to use Postgresql/Postgis database.
- __AUDIT_AWARE__ : to mark an __entity__ as audit-able. This will have additional SpringData annotations and schema with created_date, modified_date, created_by and modified_by columns.
- __EXTENDABLE__: Mark an __entity__ as extendable will add an extension fields to it and the extension schema. Extension field and schema will be stored as a JSON data.
- __VERSIONABLE__: Mark an __entity__ as versionable will add the optimistic lock _@Version_ field in the entity. 

###### 1.1 Audit

When using __AUDIT_AWARE__ annotation, you need to provide a bean to resolve the username from
the security context.
Add a new bean in the application configuration.

```java
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@SpringBootApplication
@EnableAutoConfiguration
@EnableGrpcSecurity
@EnableJpaAuditing
public class Application {

    ...

  /**
   * To resolve the user info from security context for the SpringData
   *
   * @return userid with AuditorAware object
   */
  @Bean
  public AuditorAware<String> auditorProvider() {
    return () -> {
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

      if (authentication == null || !authentication.isAuthenticated()) {
        return null;
      }

      return authentication.getPrincipal().toString();
    };
  }
}
```

The annotated entity will contains the audit fields :

   * createdBy
   * createdDate
   * modifiedBy
   * modifiedDate

![Audit fields](images/auditfields.png "Audit fields")

__WARNING__ : When you use __AUDIT_AWARE__ make sure that you don't have any attribute with the audit attribute names.


###### 1.2 Extension

When using __EXTENDABLE__ annotation on an __entity__, the entity will contain the extension data, a reference to its schema and the schema name.

```java
  @Type(type = "extensions_jsonb")
  @Column(columnDefinition = "jsonb")
  private Extensions extensions;
  
  @NonNull
  @ManyToOne(targetEntity = SchemaEntity.class, fetch = FetchType.EAGER, optional = false)
  @JoinColumn(name = "schema_version_id")
  private SchemaEntity schema;
  
  @NonNull
  private String schemaFullyQualifiedName;
```

_note_: The same data will be forwarded to the BFF transfer object (DTO) and to the Typescript object model.


#### Customization

##### Custom Validation

If the validation annotations are not enough for you, you can attach a custom validator to your
service by simply implement the generated interface and register your custom code.

Here is an example with an Address entity.

```java
public interface AddressValidationListener {
  
  /**
   * Triggered after JSR_303 validation.
   * @param entity Entity to validate
   * @param errors Map of error to populate
   * @return Map of key and error
   */
  void onAfterValidation(AddressEntity entity, Map<String, String> errors);

}
```

To register your instance, call the method registerAddressValidationListener(AddressValidationListener listener)
on the AddressServiceImpl.


##### Custom Service listener

You can attach a service listener to each entity.
Simply implement the public generated interface and attach your listener to the generated service.

Here is an example with an Address entity :

```java
interface AddressServiceListener {
  
   /**
   * Notify before the AddressEntity is saved.
   * @param entity AddressEntity to be saved.
   */
  void onBeforeSave(AddressEntity entity);
  
  /**
   * Notify after the AddressEntity has been saved.
   * @param entity AddressEntity persisted.
   */
  void onAfterSave(AddressEntity entity);
  
}
```

To register your instance, call the registerAddressServiceListener(AddressServiceListener listener) on the AddressServiceImpl.


##### Query Constraint Service listener

By default, the service will return all the entities.
If you want to restrict the data that is returned, you can add a query constraint listener that
will add some constraint to the default query.

Here is an example with an Address entity :

```java
interface AddressQueryConstraintListener {
  
  /**
   * Add User defined constraint on the query service 
   * @param root
   * @param query
   * @param builder
   * @param predicates
   */
  public void addConstraint(Root<AddressEntity> root, CriteriaQuery<?> query, CriteriaBuilder builder, List<Predicate> predicates);
}
```

To register you instance, call the registerAddressQueryConstraintListener(AddressQueryConstraintListener listener) on the AddressServiceImpl.

##### Custom Web Security Configuration

By default, a Spring Security `WebSecurityConfigurerAdapter` will be generated in the service (`WebSecurityConfiguration`).
If you want to customize it, register a new `WebSecurityConfigurerAdapter` instance.

Because the generated `WebSecurityConfiguration` calls `http.authorizeRequests()`, which matches all requests, all `HttpSecurity#authorizeRequests()` must first be prefixed with `HttpSecurity#antMatcher(String)`, eg.
```java
http.antMatcher("/address/**")
    .authorizeRequests()
    .antMatchers(HttpMethod.GET, "/address/list").hasAuthority(AddressRoles.LIST_ADDRESS)
```
This will cause the following `HttpSecurity#authorizeRequests()` to only match requests with the path matching the specified pattern (`/address/**` in this example).

Make sure your custom `WebSecurityConfigurerAdapter` instance has a lower `@Order` value (lower value = higher priority) than the generated `WebSecurityConfiguration` (defaults to `100`).

Full Example:
```java
@Configuration
@Order(Ordered.HIGHEST_PRECEDENCE)  // make sure this WebSecurityConfigurerAdapter runs before modgen's WebSecurityConfiguration
public class CustomWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.antMatcher("/public/**")
            .authorizeRequests()
            .antMatchers("/public/**").permitAll();
    }
}
```

##### Extending a Generated Spring Component

A generated Spring component (eg. `Controller`/`Service`/`Repository`) can be extended to extend/modify its behavior.

Note that you will have to annotate the subclass with the `@Primary` annotation, as Spring will try to instantiate both the subclass and the superclass.
This will tell Spring to choose the subclass when there are multiple instances.

`Service` Example:
```java
@Service
@Primary
public class ExtendedAddressService extends AddressServiceImpl {
  @Transactional
  @Override
  public void delete(String id) {
    AddressReposit repository = super.getRepository();
    AddressEntity addressEntity = repository.getOne(id);
    addressEntity.setActive(false);
    repository.save(addressEntity);
  }
}
```

`Repository` Example:
```java
@Primary
public interface AddressRepository extends AddressReposit {
  @Override
  default void delete(String id) {
    AddressEntity addressEntity = getOne(id);
    addressEntity.setActive(false);
    save(addressEntity);
  }
}
```

##### 2. Bean Validation Support
Validation can be set up for each field. Depending on the field type, different validation options will be available.
Validation will be automatically generated on the java entity objects using [Bean Validation](http://beanvalidation.org).

Generator supports Bean Validation 1.0 (JSR-303) and Bean Validation 1.1 (JSR-349)

Bean validation will then be used to automatically validate domain objects during save/update operations in service implementation.
Do remember that having these validation constraints on entity objects means JPA validates these entities automatically before being saved.

In order to user bean validation annotations, just put the exactly the same annotation in model but without `@`


E.g.

``` xml
<eAnnotations source="NotNull">
    <details key="message" value="theInt.not.null"/>
</eAnnotations>
```
``` xml
<eAnnotations source="Pattern">
    <details key="regexp" value="^[a-zA-Z0-9]{3,10}$"/>
    <details key="message" value="theString.not.alphanumeric.with.length"/>
</eAnnotations>
```

Validation has a few limitations:
* We do not yet support the repeated validation annotation style.
* grouping of validations is not supported yet


### Build

`mvn clean install`


### Releases notes

 - 0.0.1 :
    * Core generator
    * Adaptation of existing generator
    * Rename packages

    
### Supported relations
 * OneToOne
 * OneToMany 
 * ManyToMany
                     
### Extend the generator

You can easily extend the generator by creating your own class that extends __AbstractGenerator__

and override the abstract methods. 
