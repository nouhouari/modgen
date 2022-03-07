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

import java.util.Map;

/**
 * @author Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@sicpa.com>
 */
public final class ThreadLocalErrorContext {
    private static final ThreadLocal<Map<String, String>> THREAD_LOCAL_ERRORS = new ThreadLocal<Map<String, String>>();

    /**
     * set errors
     *
     * @param errors
     */
    public static void set(Map<String, String> errors) {
	    THREAD_LOCAL_ERRORS.set(errors);
    }

    /**
     * remove a particular errors list from the thread local data.
     */
    public static void unset() {
	    THREAD_LOCAL_ERRORS.remove();
    }

    /**
     * get list of error codes for the passed in key.
     *
     * @return list of errors
     */
    public static Map<String, String> get() {
	    return THREAD_LOCAL_ERRORS.get();
    }

    /**
     * Constructor. Private to prevent unnecessary instantiation.
     */
    private ThreadLocalErrorContext() {
    }
}