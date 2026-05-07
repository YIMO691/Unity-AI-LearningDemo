using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerAttack : MonoBehaviour
{
    [SerializeField] private float attackRange = 2.5f;
    [SerializeField] private float attackDamage = 34f;
    [SerializeField] private float attackCooldown = 0.5f;
    [SerializeField] private string enemyTag = "Enemy";

    private float _lastAttackTime;

    private void Update()
    {
        if (!Keyboard.current.spaceKey.wasPressedThisFrame) return;
        if (Time.time - _lastAttackTime < attackCooldown) return;

        _lastAttackTime = Time.time;

        GameObject target = FindClosestEnemyInRange();
        if (target == null)
        {
            Debug.Log("PlayerAttack: No enemy in range.");
            return;
        }

        // Support both FSM (M1) and BT (M2) enemies
        EnemyFSM fsm = target.GetComponent<EnemyFSM>();
        if (fsm != null)
        {
            Debug.Log($"PlayerAttack: Hit FSM enemy! Damage={attackDamage}");
            fsm.TakeDamage(attackDamage);
            return;
        }

        EnemyBT bt = target.GetComponent<EnemyBT>();
        if (bt != null)
        {
            Debug.Log($"PlayerAttack: Hit BT enemy! Damage={attackDamage}");
            bt.TakeDamage(attackDamage);
            return;
        }
    }

    private GameObject FindClosestEnemyInRange()
    {
        GameObject[] taggedEnemies = GameObject.FindGameObjectsWithTag(enemyTag);
        GameObject closest = null;
        float closestDist = attackRange;

        foreach (GameObject go in taggedEnemies)
        {
            float dist = Vector3.Distance(transform.position, go.transform.position);
            if (dist <= closestDist)
            {
                closestDist = dist;
                closest = go;
            }
        }

        return closest;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position, attackRange);
    }
}
