/*
 *
 * Nourreddine HOUARI CONFIDENTIAL
 *
 * All information contained herein is, and remains
 * the property of Nourreddine HOUARI and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Nourreddine HOUARI
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Nourreddine HOUARI.
 *
 * [2017] Nourreddine HOUARI SA
 * All Rights Reserved.
 */
package ${validationPackage};

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import lombok.extern.slf4j.Slf4j;
import org.springframework.util.Assert;

/**
 * Validation Util for JSR-303 to validate and process validation errors.
 *
 * @author Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@>
 */
@Slf4j
public final class PotValidationUtil {

    /**
     * Constructor. Private to prevent unnecessary instantiation.
     */
    private PotValidationUtil() {
    }

    /**
     * Validates a DTO Object against all validation groups. <br/>
     * This helper method is intended for grabbing all the messages across all
     * the groups instead of one group single time.
     *
     * @param validator
     *            the JSR-303 Validator instance
     * @param dto
     *            the object that need to be validated
     * @param clazzez
     *            list of javax.validation.groups to be validated against. order is important.
     * @return A Map of errors with property name as keys and error codes as
     *         values
     */
    public static Map<String, String> validateDTO(final Validator validator, final Object dto, Class... clazzez) {
        Assert.notNull(validator);

        Map<String, String> errors = new LinkedHashMap<String, String>();

        if(!isEmpty(clazzez)) {
           for(Class clazz : clazzez) {
               Set<ConstraintViolation<Object>> violations = validator.validate(dto, clazz);
               processConstraintVoilations(violations, errors);
           }
        } else {
            Set<ConstraintViolation<Object>> violations = validator.validate(dto);
            processConstraintVoilations(violations, errors);
        }

        processThreadLocalViolations(errors);
        return errors;
    }

    /**
     * helper method to process constraint violations and put every violation
     * into a Map
     *
     * @param violations
     *            The JSR-303 ConstraintViolation results
     * @param errors
     *            a non-null hash map to store the processed violations
     */
    public static void processConstraintVoilations(final Set<ConstraintViolation<Object>> violations,
	    final Map<String, String> errors) {
        Assert.notNull(errors);
        for (ConstraintViolation<Object> violation : violations) {
            if (!errors.containsKey(violation.getPropertyPath().toString())) {
            if (log.isTraceEnabled()) {
                log.trace("Bean Validation Constraint violation for property {} with message {}",
                    violation.getPropertyPath().toString(), violation.getMessage());
            }
            errors.put(violation.getPropertyPath().toString(), violation.getMessage());
            }
        }
    }

    /**
     * used to parse any attached errors to thread local
     *
     * @param errors
     *            a non-null hash map to store the processed violations
     */
    public static void processThreadLocalViolations(final Map<String, String> errors) {
        Assert.notNull(errors);

        if (!isEmpty(ThreadLocalErrorContext.get())) {
            Map<String, String> threadLocalErrors = ThreadLocalErrorContext.get();

            threadLocalErrors.forEach((errorKey, errorCode) -> {
            if (!errors.containsKey(errorKey)) {
                errors.put(errorKey, errorCode);
            }
            });
        }

        ThreadLocalErrorContext.unset();
    }

    /**
     * This method returns true if the collection is null or is empty.
     *
     * @param collection
     * @return true | false
     */
    private static boolean isEmpty(Collection<?> collection) {
        if (collection == null || collection.isEmpty()) {
            return true;
        }
        return false;
    }

    /**
     * This method returns true if the input array is null or its length is
     * zero.
     *
     * @param array
     * @return true | false
     */
    private static boolean isEmpty(Object[] array) {
        if (array == null || array.length == 0) {
            return true;
        }
        return false;
    }
    
    /**
     * This method returns true if the collection is null or is empty.
     *
     * @param collection
     * @return true | false
     */
    private static boolean isEmpty(Map<?, ?> collection) {
        if (collection == null || collection.isEmpty()) {
            return true;
        }
        return false;
    }
}