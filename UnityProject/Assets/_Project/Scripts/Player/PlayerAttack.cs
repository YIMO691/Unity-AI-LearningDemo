using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerAttack : MonoBehaviour
{
    [SerializeField] private float attackRange = 2.5f;
    [SerializeField] private float attackDamage = 34f;
    [SerializeField] private float attackCooldown = 0.5f;

    private float _lastAttackTime;

    private void Update()
    {
        if (!Keyboard.current.spaceKey.wasPressedThisFrame) return;
        if (Time.time - _lastAttackTime < attackCooldown) return;

        Debug.Log("PlayerAttack: Space pressed, checking for enemy...");

        _lastAttackTime = Time.time;

        EnemyFSM enemy = FindClosestEnemyInRange();
        if (enemy != null)
        {
            Debug.Log($"PlayerAttack: Hit! Damage={attackDamage}");
            enemy.TakeDamage(attackDamage);
        }
        else
        {
            Debug.Log("PlayerAttack: No enemy in range.");
        }
    }

    private EnemyFSM FindClosestEnemyInRange()
    {
        EnemyFSM[] enemies = FindObjectsByType<EnemyFSM>(FindObjectsInactive.Exclude, FindObjectsSortMode.None);
        EnemyFSM closest = null;
        float closestDist = attackRange;

        foreach (EnemyFSM e in enemies)
        {
            float dist = Vector3.Distance(transform.position, e.transform.position);
            if (dist <= closestDist)
            {
                closestDist = dist;
                closest = e;
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
